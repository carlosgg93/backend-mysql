import { Router } from 'express';
import { TournamentsModel } from '../models/tournamentsModel.js';

const tournamentsRouter = Router();

tournamentsRouter.get('/', async (req, res) => {
  const tournaments = await TournamentsModel.getAllTournaments();
  res.json(tournaments);
});

tournamentsRouter.get('/:id', async (req, res) => {});

// tournamentsRouter.delete('/:id', getAuth, async (req, res, next) => {

// })

// tournamentsRouter.post('/', getAuth, async (req, res, next) => {

// })

export default tournamentsRouter;
