import { Router } from 'express';
import bcrypt from 'bcrypt';
import ManagerModel from '../models/managerModel.js';
import jwt from 'jsonwebtoken';
import { JWT_SECRET } from '../utils/config.js';

const loginRouter = Router();

loginRouter.post('/', async (req, res) => {
  const { body } = req;
  const { email, password } = body;

  const manager = await ManagerModel.getManagerByEmail(email);
  const passwordCorrect = manager === null ? false : await bcrypt.compare(password, manager.password);

  if (!(manager && passwordCorrect)) {
    return res.status(401).json({
      error: 'invalid username or password',
    });
  }

  jwt.sign({ email, id: manager.id }, JWT_SECRET, (err, token) => {
    if (err) {
      return res.status(500).json({
        error: 'error signing token',
      });
    }
    return res.status(200).json({
      token,
      id: manager.id,
      name: manager.name,
      surname: manager.surname,
      email: manager.email,
    });
  });
});

export default loginRouter;
