import { Router } from 'express';
import ManagerModel from '../models/managerModel.js';
import { getAuth } from '../middlewares/getAuth.js';
import bcrypt from 'bcrypt';

const managersRouter = Router();

managersRouter.get('/', async (req, res) => {
  const managers = await ManagerModel.getAllManagers();
  res.json(managers);
});

managersRouter.get('/:id', async (req, res) => {
  const { id } = req.params;
  const manager = await ManagerModel.getManagerById(id);
  res.json(manager);
});

managersRouter.delete('/:id', getAuth, async (req, res, next) => {
  const { id } = req.params;
  await ManagerModel.deleteManagerById(id);
  res.status(204).end();
});

managersRouter.post('/', async (req, res, next) => {
  const { body } = req;
  const { name, surname, age, date_of_birth, email, password, phone, image, id_genre, id_city, id_club } = body;

  if (!name || !surname || !age || !date_of_birth || !email || !password || !phone || !image || !id_genre || !id_city || !id_club) {
    return res.status(400).json({
      error: 'content missing',
    });
  }

  const passwordHash = bcrypt.hashSync(password, 10);

  const manager = {
    name,
    surname,
    age,
    date_of_birth,
    email,
    passwordHash,
    phone,
    image,
    id_genre,
    id_city,
    id_club,
  };

  const insertedId = await ManagerModel.addManager(manager);
  res.status(201).json(insertedId);
});

managersRouter.put('/:id', getAuth, async (req, res, next) => {
  const manager = req.body;
  const { id } = req.params;
  await ManagerModel.updateManagerById(id, manager);
  res.status(201).end();
});

export default managersRouter;
