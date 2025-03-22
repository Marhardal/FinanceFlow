namespace FinanceFlow.Server.DTOs
{
    public class RefreshTokenDTO
    {
        public Guid UserId { get; set; }

        public required string refreshToken { get; set; }
    }
}
