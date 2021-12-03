export interface ITokenPayload {
  userId: string;
  firstName: string;
  lastName: string;
}

export interface ITokenResponse {
  userId: string;
  issued: number;
  expires: number;
  token: string;
  firstName: string;
  lastName: string;
}

export interface IDecodedToken {
  userId: string;
  iat: number;
  exp: number;
}