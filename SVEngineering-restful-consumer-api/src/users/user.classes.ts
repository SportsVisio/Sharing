import { ApiProperty } from '@nestjs/swagger';

export class GetUserParams {
  @ApiProperty({
    description: "Optional String guid of user. If omitted, user record for authenticated user is returned",
    required: false
  })
  userId?: string;
}

export class UserSignupInput {
  @ApiProperty({
    description: "Email address to register."
  })
  email: string;

  @ApiProperty({
    minLength: 5
  })
  password?: string;

  @ApiProperty()
  firstName: string;

  @ApiProperty()
  lastName: string;
}

export class UserForgotPasswordInput {
  @ApiProperty({
    description: "Email address to recover."
  })
  email: string;
}

// NOTE: for future use when email / token verification is needed
export class UserActivateInput {
  @ApiProperty({
    description: "Activation token"
  })
  signupToken: string;
}

export class UserUpdateInput {
  @ApiProperty()
  email?: string;

  @ApiProperty()
  firstName?: string;

  @ApiProperty()
  lastName?: string;

  @ApiProperty({
    minLength: 5
  })
  password?: string;
}