namespace FinanceFlow.Server.DTOs
{
    public class TokenRefresh
    {
        public required string? AccessToken { get; set; }

        public required string? RefrshToken { get; set; }

        public int UserID { get; set; }

        public int RoleID { get; set; }
    }
}
