//= require moment
//= require fullcalendar

$(function () {
    if (!($("body.calendar").length > 0)) {
        return;
    }

    $('#calendar').fullCalendar({
        events: 'calendar.json',
        header: {
            'left': 'prev,next today',
            'right': 'month,agendaWeek,agendaDay'
        },
        dayClick: function (date, jsEvent, view) {
            $("#calendar").fullCalendar('gotoDate', date);
            $("#calendar").fullCalendar('changeView', 'agendaDay');
        }
    })
});