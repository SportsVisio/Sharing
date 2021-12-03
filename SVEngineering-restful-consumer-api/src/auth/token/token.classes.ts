import { ITokenResponse } from './token.interfaces';
import { ApiProperty } from '@nestjs/swagger';

export class TokenResponse implements ITokenResponse {
  @ApiProperty({
    example: "7a5e7bf4-ad48-4a01-b64b-46f515de2c86"
  })
  userId: string;

  @ApiProperty({
    example: "John"
  })
  firstName: string;

  @ApiProperty({
    example: "Smith"
  })
  lastName: string;

  @ApiProperty({
    description: "Unix Timestamp",
    example: new Date().getTime()
  })
  issued: number;

  @ApiProperty({
    description: "Unix Timestamp",
    example: new Date().getTime()
  })
  expires: number;

  @ApiProperty({
    example: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWU3YmY0LWFkNDgtNGEwMS1iNjRiLTQ2ZjUxNWRlMmM4NiIsImNyZWF0ZWQiOiIyMDIwLTA5LTIyVDIzOjE3OjQ1Ljc1NloiLCJpYXQiOjE2MDA4MTY2NjUsImV4cCI6MTYwMDgyMDI2NX0.YTPBuD5lnjPWz0GMKtfE3wcu8sYWeFPTEqqnWyjmgKg"
  })
  token: string;
}