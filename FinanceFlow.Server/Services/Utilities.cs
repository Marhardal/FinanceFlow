using System.Net.Mail;

namespace FinanceFlow.Server.Services
{
    public class Utilities
    {
        public static void SendMail(string ToEmail, string Subject, string Body)
        {
            try
            {
                MailMessage mail = new MailMessage();
                string[] ToEmailArray = ToEmail.Split(',');
                foreach (string email in ToEmailArray)
                {
                    if (email != "")
                    {
                        mail.To.Add(email);
                    }
                }
                
                mail.From = new MailAddress("finflow.noreply@gmail.com", "Finance Flow");
                mail.Subject = Subject;
                mail.Body = Body;
                mail.IsBodyHtml = true;

                //mail.Attachments.Add(new Attachment(spath));
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com"; //Or Your SMTP Server Address
                smtp.Port = 587;
                //smtp.UseDefaultCredentials = true;
                smtp.Credentials = new System.Net.NetworkCredential("finflow.noreply@gmail.com", "?*fin%^20@<25@-flow");
                smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smtp.EnableSsl = true;
                //////System.Net.ServicePointManager.SecurityProtocol = (SecurityProtocolType)(0xc0 | 0x300 | 0xc00);
                smtp.Timeout = 300000;
                smtp.EnableSsl = true;
                smtp.Send(mail);
            }
            catch (Exception ex)
            {
                //throw ex;
            }
        }
    }
}
