import { Router } from "express";
import {MovieModel} from '../models/movieModel.js';

const moviesRouter = Router();

moviesRouter.get('/', async (req, res) => {
  const movies = await MovieModel.getAllMovies();
  res.json(movies);
})

moviesRouter.get('/:id', async (req, res) => {
  
})

// moviesRouter.delete('/:id', getAuth, async (req, res, next) => {
  
// })

// moviesRouter.post('/', getAuth, async (req, res, next) => {
  
// })

export default moviesRouter;