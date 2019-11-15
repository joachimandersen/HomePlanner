using System.Data;
using Microsoft.Extensions.Configuration;
using Npgsql;

namespace Calendar.Model.DataContext
{
    public interface ICalendarContext
    {
        IDbConnection Create();   
    }

    public class CalendarContext: ICalendarContext
    {
        private readonly IConfiguration _configuration;
        public CalendarContext(IConfiguration configuration)
        {
            _configuration = configuration;
        }
        public IDbConnection Create()
        {
            return new NpgsqlConnection(_configuration.GetConnectionString("DefaultConnection"));
        }
    }
}