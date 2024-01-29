import { Router } from 'express';
import { TournamentModel } from '../models/tournamentModel.js';
import { getAuth } from '../middlewares/getAuth.js';

const tournamentsRouter = Router();

tournamentsRouter.get('/', async (req, res) => {
  const tournaments = await TournamentModel.getAllTournaments();
  res.json(tournaments);
});

tournamentsRouter.get('/:id', async (req, res) => {
  const { id } = req.params;
  const tournament = await TournamentModel.getTournamentById(id);
  res.json(tournament);
});

tournamentsRouter.delete('/:id', getAuth, async (req, res, next) => {
  const { id } = req.params;
  await TournamentModel.deleteTournamentById(id);
  res.status(204).end();
});

tournamentsRouter.post('/', getAuth, async (req, res, next) => {
  const tournament = req.body;
  await TournamentModel.addTournament(tournament);
  res.status(201).end();
});

tournamentsRouter.put('/:id', getAuth, async (req, res, next) => {
  const tournament = req.body;
  const { id } = req.params;
  await TournamentModel.updateTournamentById(id, tournament);
  res.status(201).end();
});

export default tournamentsRouter;
