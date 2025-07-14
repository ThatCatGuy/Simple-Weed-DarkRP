function SimpleWeedTimeLeftString(seconds)
    seconds = math.Round(seconds)
    return string.FormattedTime( seconds, "%2i:%02i" )
end