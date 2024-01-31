import jwt from 'jsonwebtoken';
import { JWT_SECRET } from '../utils/config.js';

export const getAuth = (request, response, next) => {
  const auth = request.get('authorization') || request.body.token || request.headers['x-access-token'];
  let token = '';

  if (auth && auth.toLowerCase().startsWith('bearer')) {
    token = auth.substring(7);
  }

  const decodedToken = jwt.verify(token, JWT_SECRET);

  if (!token || !decodedToken.id) {
    return response.status(401).json({ error: 'token missing or invalid' });
  }

  const { id: userId } = decodedToken;

  request.userId = userId;

  next();
};
