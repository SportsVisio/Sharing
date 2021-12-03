import { AccountMemberRoles } from './account-member-role.entity';
import { ApiProperty } from '@nestjs/swagger';

export class GetAccountParams {
  @ApiProperty({
    description: "Optional String guid of account. If omitted, account record for authenticated user is returned",
    required: false
  })
  accountId?: string;
}

export class InviteAccountMemberParams {
  @ApiProperty({
    description: "AccountId to invite member"
  })
  accountId: string;
}

export class AcceptAccountInviteParams {
  @ApiProperty({
    description: "Invite token sent to member"
  })
  token: string;
}

export class AssignRoleParams {
  @ApiProperty({
    description: "Account Member-Role assignment id"
  })
  accountMemberRoleAssnId: string;
}

export class UnAssignRoleParams {
  @ApiProperty({
    description: "Role assignment id to remove"
  })
  roleAssignmentId: string;
}

export class InviteAccountMemberPayload {
  @ApiProperty({
    description: "Email address to send invite"
  })
  email: string; 
}

export class AssignMemberRolePayload {
  @ApiProperty({
    description: "Member role to assign",
    enum: AccountMemberRoles,
  })
  role: AccountMemberRoles; 
}