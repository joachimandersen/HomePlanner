using Calendar.Model.DataContext;
using Calendar.Model;
using System.Collections.Generic;
using System.Threading.Tasks;
using Dapper;
using System.Linq;

namespace Calendar.Repository
{
    public interface ICalendarRepository
    {
        Task<IEnumerable<CalendarEntity>> GetCalendars();
        Task<IEnumerable<CalendarEntity>> GetCalendar(int id);
        Task<CalendarEntity> Add(string name);
    }

    public class CalendarRepository: ICalendarRepository
    {
        private readonly ICalendarContext _context;
        public CalendarRepository(ICalendarContext context)
        {
            _context = context;   
        }

        public async Task<IEnumerable<CalendarEntity>> GetCalendars()
        {
            using (var ctx = _context.Create())
            {
                ctx.Open();
                var calendars = await ctx.QueryAsync<CalendarEntity>("SELECT * FROM Calendar.Calendar");
                return calendars.ToArray();
            }
        }
        public async Task<IEnumerable<CalendarEntity>> GetCalendar(int id)
        {
            using (var ctx = _context.Create())
            {
                ctx.Open();
                var sql = $"SELECT * FROM Calendar.Calendar WHERE Id = {id}";
                var calendars = await ctx.QueryAsync<CalendarEntity>(sql);
                return calendars.ToArray();
            }
        }

        public async Task<CalendarEntity> Add(string name)
        {
            using (var ctx = _context.Create())
            {
                ctx.Open();
                var calendar = new CalendarEntity
                {
                    Name = name
                };
                var insertSql = @"INSERT INTO Calendar.Calendar (Name) VALUES (@name) RETURNING Id";
                var id = await ctx.ExecuteScalarAsync<int>(insertSql, calendar);
                calendar.Id = id;
                return calendar;
            }
        }
    }
}