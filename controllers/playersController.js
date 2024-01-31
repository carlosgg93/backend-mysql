import { Router } from 'express';
import { PlayerModel } from '../models/playerModel.js';
import { getAuth } from '../middlewares/getAuth.js';
import bcrypt from 'bcrypt';

const playersRouter = Router();

playersRouter.get('/', async (req, res) => {
  const players = await PlayerModel.getAllPlayers();
  res.json(players);
});

playersRouter.get('/:id', async (req, res) => {
  const { id } = req.params;
  const player = await PlayerModel.getPlayerById(id);
  res.json(player);
});

playersRouter.delete('/:id', getAuth, async (req, res, next) => {
  const { id } = req.params;
  await PlayerModel.deletePlayerById(id);
  res.status(204).end();
});

playersRouter.post('/', getAuth, async (req, res, next) => {
  const { body } = req;
  const { name, surname, age, date_of_birth, email, password, phone, image, position, id_genre, id_city } = body;

  if (!name || !surname || !age || !date_of_birth || !email || !password || !phone || !image || !id_genre || !id_city || !position) {
    return res.status(400).json({
      error: 'content missing',
    });
  }

  const passwordHash = bcrypt.hashSync(password, 10);

  const player = {
    name,
    surname,
    age,
    date_of_birth,
    email,
    passwordHash,
    phone,
    image,
    position,
    id_genre,
    id_city,
  };

  const insertedId = PlayerModel.addPlayer(player);
  res.status(201).json(insertedId);
});

playersRouter.put('/:id', getAuth, async (req, res, next) => {
  const player = req.body;
  const { id } = req.params;
  await PlayerModel.updatePlayerById(id, player);
  res.status(201).end();
});

export default playersRouter;
