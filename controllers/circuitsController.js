import { Router } from 'express';
import { CircuitModel } from '../models/circuitModel.js';
import { getAuth } from '../middlewares/getAuth.js';

const circuitRouter = Router();

circuitRouter.get('/', async (req, res) => {
  const circuits = await CircuitModel.getAllCircuits();
  res.json(circuits);
});

circuitRouter.get('/:id', async (req, res) => {
  const { id } = req.params;
  const circuit = await CircuitModel.getCircuitById(id);
  res.json(circuit);
});

circuitRouter.delete('/:id', getAuth, async (req, res, next) => {
  const { id } = req.params;
  await CircuitModel.deleteCircuitById(id);
  res.status(204).end();
});

circuitRouter.post('/', getAuth, async (req, res, next) => {
  const circuit = req.body;
  await CircuitModel.addCircuit(circuit);
  res.status(201).end();
});

circuitRouter.put('/:id', getAuth, async (req, res, next) => {
  const circuit = req.body;
  const { id } = req.params;
  await CircuitModel.updateCircuitById(id, circuit);
  res.status(201).end();
});

export default circuitRouter;
