module Constants
  DUMMY_EVENTS_LIST = [
    {
      "id" => "999999999999999",
      "name" => "Dummy Event 1",
      "is_canceled"=> false,
      "attending_count"=> 100,
      "maybe_count"=> 200,
      "interested_count"=> 150,
      "cover"=> {
        "offset_x"=> 0,
        "offset_y"=> 0,
        "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
        "id"=> "861505993897921"
      },
      "start_time" => "2015-08-29T00:00:00+0530"
    },
    {
      "id" => "999999999999998",
      "name" => "Dummy Event 2",
      "is_canceled"=> false,
      "attending_count"=> 200,
      "maybe_count"=> 100,
      "interested_count"=> 100,
      "cover"=> {
        "offset_x"=> 0,
        "offset_y"=> 0,
        "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
        "id"=> "861505993897921"
      },
      "start_time" => "2015-08-29T00:00:00+0530"
    },
    {
      "id" => "999999999999997",
      "name" => "Dummy Event 3",
      "is_canceled"=> false,
      "attending_count"=> 500,
      "maybe_count"=> 400,
      "interested_count"=> 1100,
      "cover"=> {
        "offset_x"=> 0,
        "offset_y"=> 0,
        "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
        "id"=> "861505993897921"
      },
      "start_time" => "2015-08-29T00:00:00+0530"
    },
    {
      "id" => "999999999999996",
      "name" => "Dummy Event 4",
      "is_canceled"=> false,
      "attending_count"=> 1500,
      "maybe_count"=> 1200,
      "interested_count"=> 800,
      "cover"=> {
        "offset_x"=> 0,
        "offset_y"=> 0,
        "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
        "id"=> "861505993897921"
      },
      "start_time" => "2015-08-29T00:00:00+0530"
    },
    {
      "id" => "999999999999995",
      "name" => "Dummy Event 5",
      "is_canceled"=> false,
      "attending_count"=> 500,
      "maybe_count"=> 1200,
      "interested_count"=> 1100,
      "cover"=> {
        "offset_x"=> 0,
        "offset_y"=> 0,
        "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
        "id"=> "861505993897921"
      },
      "start_time" => "2015-08-29T00:00:00+0530"
    }

  ]

  DUMMY_EVENT_SHOW = {
    "id" => "613215878780653",
    "name" => "Dummy Event - Shootout Championship",
    "cover"=> {
      "offset_x"=> 0,
      "offset_y"=> 0,
      "source"=> "https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-xlf1/t31.0-8/s720x720/11041934_861505993897921_8261515772935041361_o.jpg",
      "id"=> "861505993897921"
    },
    "description"=> "Card based tournament. Play to reach to the top in leader-board.
  It needs 100% skill 50% luck.
  Its a knockout tournament, a new event introduced in BITotsav'15 that is free of cost with promising gifts & prizes. 
  Register yourself @ http://www.shootoutchampionship.com/
  Play Hard, Go Pro!.",
    "is_canceled"=> false,
    "is_viewer_admin"=> false,
    "attending_count"=> 129,
    "maybe_count"=> 17,
    "interested_count"=> 17,
    "noreply_count"=> 1810,
    "declined_count"=> 28,
    "owner"=> {
      "name"=> "ShootoutChampionship",
      "id"=> "860068950708292"
    },
    "place" => {
      "name" => "He Said She Said - Mumbai",
      "location" => {
        "city" => "Mumbai",
        "country" => "India",
        "latitude" => 19.134105832915,
        "longitude" => 72.836869288832,
        "street" => "Veera Desai Road, Andheri (W)",
        "zip" => "400053"
      },
      "id" => "603052483066057"
    },
    "start_time"=> "2015-03-21T10:00:00+0530",
    "end_time"=> "2015-03-23T14:00:00+0530",
    "timezone"=> "Asia/Kolkata"
  }

  PAGING = {
    "cursors": {
      "before": "TmprMk9UazVORFkzTVRBMk56QTNPakUwTkRBNE16RTJNREE2TVRZAMU1EZAzBPRGsyT0RRNE5UZA3gZD",
      "after": "TkRReU56RTFOVGt5TkRJMk56RTRPakV6TkRFeU9EWXlNREE2TVRZAMU1EZAzBPRGsyT0RRNE5UZA3gZD"
    },
    "next": "https://graph.facebook.com/v2.7/10153857359586274/events?access_token=EAAEy9c638G8BAJTuGmjXOOVO00yPIlbt63ZA6Tz3mfvQtnFiOHKvNfcLHA0BYI9WkrCyj8Xx8KtiA7sQXc4ByvdzcjU2BcyV5giZBWFcqIDnZCmdmbsJdvhqUUU96lA0oYnc2YIsTgdSZC8IgZBfm&pretty=0&fields=id%2Cname%2Ccover%2Cis_canceled%2Cattending_count%2Cmaybe_count%2Cinterested_count%2Cstart_time&type=attending&limit=25&after=TkRReU56RTFOVGt5TkRJMk56RTRPakV6TkRFeU9EWXlNREE2TVRZAMU1EZAzBPRGsyT0RRNE5UZA3gZD"
  }

end