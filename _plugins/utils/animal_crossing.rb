module AnimalCrossing
  # TODO: is this the best way to store these values?
  @@SORT_ORDERS = {
    :residents => [
      "self_portraits",
      "avalar_museum",
      "dom",
      "ursula",
      "ken",
    ]
  }

  @@GRASS_COLORS = {
    :"1210-0224" => "rgb(189, 215, 238)",
    :"0225-0331" => "rgb(31, 140, 57)",
    :"0401-0722" => "rgb(0, 131, 90)",
    :"0723-0915" => "rgb(19, 115, 82)",
    :"0916-0930" => "rgb(73, 123, 49)",
    :"1001-1015" => "rgb(132, 123, 58)",
    :"1016-1029" => "rgb(148, 99, 99)",
    :"1030-1112" => "rgb(148, 90, 98)",
    :"1113-1128" => "rgb(132, 90, 82)",
    :"1129-1209" => "rgb(99, 81, 82)",
  }

  @@ASTROLOGY_DATE_RANGES = {
    :capricorn => "1222-0119",
    :aquarius => "0120-0218",
    :pisces => "0219-0320",
    :aries => "0321-0419",
    :taurus => "0420-0520",
    :gemini => "0521-0621",
    :cancer => "0622-0722",
    :leo => "0723-0822",
    :virgo => "0823-0922",
    :libra => "0923-1023",
    :scorpio => "1024-1122",
    :sagittarius => "1123-1221"
  }

  def self.get_star_fragment(date)
    month = date.month
    day = date.day

    case month
    when 1
      if day <= 19 then
        @@ASTROLOGY_DATE_RANGES[:capricorn]
      else
        @@ASTROLOGY_DATE_RANGES[:aquarius]
      end
    when 2
      if day <= 18 then
        @@ASTROLOGY_DATE_RANGES[:aquarius]
      else
        @@ASTROLOGY_DATE_RANGES[:pisces]
      end
    when 3
      if day <= 20 then
        @@ASTROLOGY_DATE_RANGES[:pisces]
      else
        @@ASTROLOGY_DATE_RANGES[:aries]
      end
    when 4
      if day <= 19 then
        @@ASTROLOGY_DATE_RANGES[:aries]
      else
        @@ASTROLOGY_DATE_RANGES[:taurus]
      end
    when 5
      if day <= 20 then
        @@ASTROLOGY_DATE_RANGES[:taurus]
      else
        @@ASTROLOGY_DATE_RANGES[:gemini]
      end
    when 6
      if day <= 21 then
        @@ASTROLOGY_DATE_RANGES[:gemini]
      else
        @@ASTROLOGY_DATE_RANGES[:cancer]
      end
    when 7
      if day <= 22 then
        @@ASTROLOGY_DATE_RANGES[:cancer]
      else
        @@ASTROLOGY_DATE_RANGES[:leo]
      end
    when 8
      if day <= 22 then
        @@ASTROLOGY_DATE_RANGES[:leo]
      else
        @@ASTROLOGY_DATE_RANGES[:virgo]
      end
    when 9
      if day <= 22
        @@ASTROLOGY_DATE_RANGES[:virgo]
      else
        @@ASTROLOGY_DATE_RANGES[:libra]
      end
    when 10
      if day <= 23
        @@ASTROLOGY_DATE_RANGES[:libra]
      else
        @@ASTROLOGY_DATE_RANGES[:scorpio]
      end
    when 11
      if day <= 22
        @@ASTROLOGY_DATE_RANGES[:scorpio]
      else
        @@ASTROLOGY_DATE_RANGES[:sagittarius]
      end
    when 12
      if day <= 21
        @@ASTROLOGY_DATE_RANGES[:sagittarius]
      else
        @@ASTROLOGY_DATE_RANGES[:capricorn]
      end
    end
  end
end