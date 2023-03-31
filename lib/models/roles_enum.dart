enum Roles { admin, teamMember }

Roles getRoleById(String roleId) {
  if (roleId == 'NzLaILQ50q1wbbEBc2v5') {
    return Roles.teamMember;
  } else {
    return Roles.admin;
  }
}

String? getRoleIdByEnum(Roles role) {
  switch (role) {
    case Roles.admin:
      return 'UOx8hrqFdagnwpaj5Faw';
    case Roles.teamMember:
      return 'NzLaILQ50q1wbbEBc2v5';
    default:
      return null;
  }
}
