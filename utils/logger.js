export const info = (...params) => {
  if (process.env.NODE_ENV === 'development') {
    console.log(...params);
  }
};

export const error = (...params) => {
  console.error(...params);
};
