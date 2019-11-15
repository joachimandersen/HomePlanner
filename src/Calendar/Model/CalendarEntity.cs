using System.ComponentModel.DataAnnotations;

namespace Calendar.Model
{
    public class CalendarEntity
    {
        [Key]
        public int Id { get; set; }
        [Required]
        public string Name { get; set; }
    }
}