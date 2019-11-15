using System;

namespace Calendar.Model
{
    public class Item
    {
        public int Id { get; set; }
        public int CalendarEntityId { get; set; }
        public DateTime Date { get; set; }
        public int Title { get; set; }
        public string Description { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedAt { get; set; }
    }
}