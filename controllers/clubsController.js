import { Router } from 'express';
import { ClubModel } from '../models/clubModel.js';
import { getAuth } from '../middlewares/getAuth.js';

const clubRouter = Router();

clubRouter.get('/', async (req, res) => {
  const clubs = await ClubModel.getAllClubs();
  res.json(clubs);
});

clubRouter.get('/:id', async (req, res) => {
  const { id } = req.params;
  const club = await ClubModel.getClubById(id);
  res.json(club);
});

clubRouter.delete('/:id', getAuth, async (req, res, next) => {
  const { id } = req.params;
  await ClubModel.deleteClubById(id);
  res.status(204).end();
});

clubRouter.post('/', getAuth, async (req, res, next) => {
  const club = req.body;
  await ClubModel.addClub(club);
  res.status(201).end();
});

clubRouter.put('/:id', getAuth, async (req, res, next) => {
  const club = req.body;
  const { id } = req.params;
  await ClubModel.updateClubById(id, club);
  res.status(201).end();
});

export default clubRouter;
