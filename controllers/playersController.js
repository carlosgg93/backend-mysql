import { Router } from 'express';
import { PlayerModel } from '../models/playerModel.js';
import { getAuth } from '../middlewares/getAuth.js';

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
  const player = req.body;
  await PlayerModel.addPlayer(player);
  res.status(201).end();
});

playersRouter.put('/:id', getAuth, async (req, res, next) => {
  const player = req.body;
  const { id } = req.params;
  await PlayerModel.updatePlayerById(id, player);
  res.status(201).end();
});

export default playersRouter;
