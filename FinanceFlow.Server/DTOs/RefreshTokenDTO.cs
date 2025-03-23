namespace FinanceFlow.Server.DTOs
{
    public class RefreshTokenDTO
    {
        public int UserId { get; set; }

        public required string refreshToken { get; set; }
    }
}
