QBScoreboard = {}

$(document).ready(function () {
    window.addEventListener('message', function (event) {
        switch (event.data.action) {
            case "open":
                QBScoreboard.Open(event.data);
                break;
            case "close":
                QBScoreboard.Close();
                break;
        }
    })
});


QBScoreboard.Open = function (data) {
    if (data.theme == "rounded") {
        $(".scoreboard-block-first").fadeIn(150);
        $("#total-players-first").html("<p>" + data.players + "</p>");
        $("#time-players-first").html(data.timehour + "h " + data.timemenu + "m 🕓");
        $("#ogtal3b").html("<p>" + data.ogtal3b + "</p>");

        $.each(data.requiredCops, function (i, category) {
            var beam = $(".scoreboard-info-first").find('[data-type="' + i + '"]');
            var status = $(beam).find(".info-beam-status-first");


            if (category.busy) {
                $(status).html('<i class="fas fa-clock"></i>');
            } else if (data.currentCops >= category.minimum) {
                $(status).html('<i class="fas fa-circle" style="color: #2CF8B0;"></i>');
            } else {
                $(status).html('<i class="fas fa-circle" style="color: #EC1B28;"></i>');
            }

            $("#bateal-pass").html("<p>"+data.ogtal3b+"</p>");

            if (data.currentAmbulance > 0) {
                var Abeam = $(".scoreboard-info-first").find('[data-type="ambulance"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #2CF8B0;"></i>');
            } else {
                var Abeam = $(".scoreboard-info-first").find('[data-type="ambulance"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #EC1B28;"></i>');

            }
            if (data.currentrealestate > 0) {
                var Abeam = $(".scoreboard-info-first").find('[data-type="realestate"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #2CF8B0;"></i>');
            } else {
                var Abeam = $(".scoreboard-info-first").find('[data-type="realestate"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #EC1B28;"></i>');
            }

            if (data.currentcardealer > 0) {
                var Abeam = $(".scoreboard-info-first").find('[data-type="cardealer"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #2CF8B0;"></i>');
            } else {
                var Abeam = $(".scoreboard-info-first").find('[data-type="cardealer"]');
                var Astatus = $(Abeam).find(".info-beam-status-first");
                $(Astatus).html('<i class="fas fa-circle" style="color: #EC1B28;"></i>');
            }
        });
    } else {
        $(".scoreboard-block-sec").fadeIn(150);
        $("#total-players-sec").html("<p>" + 1 + "</p>");
        $("#ogtal3b").html("<p>" + 1 + "</p>");

        $.each(data.requiredCops, function (i, category) {
            var beam = $(".scoreboard-info-sec").find('[data-type="' + i + '"]');
            var status = $(beam).find(".info-beam-status-sec");
            if (category.busy) {
                $(status).html('<i class="fas fa-clock"></i>');
            } else if (data.currentCops >= category.minimum) {
                $(status).html('<i class="fa-solid fa-circle green"></i>');
            } else {
                $(status).html('<i class="fa-solid fa-circle red"></i>');
            }

            if (data.currentAmbulance > 0) {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="ambulance"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle green"></i>');
            } else {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="ambulance"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle red"></i>');

            }
            if (data.currentrealestate > 0) {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="realestate"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle green"></i>');
            } else {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="realestate"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle red"></i>');
            }

            if (data.currentcardealer > 0) {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="cardealer"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle green"></i>');
            } else {
                var Abeam = $(".scoreboard-info-sec").find('[data-type="cardealer"]');
                var Astatus = $(Abeam).find(".info-beam-status-sec");
                $(Astatus).html('<i class="fas fa-circle red"></i>');
            }
        });
    }
}

QBScoreboard.Close = function () {
    $(".scoreboard-block-first").fadeOut(150);
    $(".scoreboard-block-sec").fadeOut(150);
}