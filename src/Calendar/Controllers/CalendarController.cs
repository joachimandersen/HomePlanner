using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Calendar.Model;
using Calendar.Repository;

namespace Calendar.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CalendarController : ControllerBase
    {
        private readonly ICalendarRepository _calendarRepository;
        public CalendarController(ICalendarRepository calendarRepository)
        {
            _calendarRepository = calendarRepository;   
        }

        [HttpGet]
        public async Task<IActionResult> Get()
        {
            return Ok(await _calendarRepository.GetCalendars());
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> Get(int id)
        {
            return Ok(await _calendarRepository.GetCalendar(id));
        }

        [HttpPost]
        public async Task<IActionResult> Post([FromBody] string name)
        {
            return Ok(await _calendarRepository.Add(name));
        }

        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
