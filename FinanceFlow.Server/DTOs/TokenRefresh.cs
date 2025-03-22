namespace FinanceFlow.Server.DTOs
{
    public class TokenRefresh
    {
        public required string? AccessToken { get; set; }

        public required string? RefrshToken { get; set; }

        public Guid UserID { get; set; }

        public Guid RoleID { get; set; }
    }
}
