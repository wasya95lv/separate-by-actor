--[[
README:

Omae wa moe shindeiru
]]

--
script_name = "Separate by \"Actor\""
script_author = "Regnant"
script_versin = "0.1beta"
script_description = "Generate separate srt files based on string \"Actor\""
--


function main(subtitles)
    --[[ body
    num_lines = subtitles.n
    --aegisub.debug.out("Number of rows in ass file: %d",num_lines);
    for i=1, num_lines, 1 do
        --aegisub.log("%s \n",subtitles[i].class);
        if subtitles[i].class == "dialogue" and not (subtitles[i].actor==".") then 
            --aegisub.log("%d.\n%s\n\n", i, subtitles[i].text);
            --aegisub.log("Actor: ###%s### \n", subtitles[i].actor);
            aegisub.log( convertRowToSrt(subtitles[i], i) )
        end
    end
    ]]
    actrs = include "actors.lua"
    aegisub.log(actrs[1]);
    getActorsList()
end


--Cheks if subtitles includes "Actor" field
function validateInput()
    -- body

end


--Converts time from ms to hh:mm:ss,ms format
function convertTime(input)
    local hh = math.floor(input / (60 * 60 * 1000))
    local mm = math.floor((input / (1000 * 60))) % 60
    local ss = math.floor((input / 1000)) % 60
    local ms = input % 1000

    return string.format("%02d:%02d:%02d,%03d", hh, mm, ss, ms)
end


--Converts line from ASS to SRT format
function convertRowToSrt(row, number) 
    local startTime = convertTime(row.start_time)
    local endTime = convertTime(row.end_time)
    local dialogue = row.text:gsub("\\N","\n"):gsub("{.*}","")
    
    return string.format("\n%d\n%s --> %s\n%s\n", number, startTime,endTime,dialogue)
end


function getActorsList()
    local actors = {}
    
    aegisub.log("Actors from config: \n")
    actors_file = io.open("actors.txt", "r")
    --local data = actors_file:read("*a")
        
    for line in actors_file:lines() do
        table.insert(actors, line);
    end

    actors_file:close()

    for i=1, #actors, 1 do
        aegisub.log("%s \n", actors[i])
    end

    return actors
end


function getSeperatedSubtitles(subtitles, actors)
    local subtitlesByActor = {}
    
    --Creating subtables for each actor
    for i in actors do
        subtitlesByActor[ actors[i] ] = {}
    end

    --[[Filling subtables of subtitlesByActor with 
        subtitle rows selcted by actor]]
    for i = 1, #subtitles, 1 do
        for actor in pairs(actors) do
            if string.find(subtitles[i].actor, actors[actor]) then
               table.insert(subtitlesByActor[ actors[actor] ], subtitles[i])
            end
        end
    end

    return subtitlesByActor
end


function convertAllRows(seperatedSubtitles)
    for actor in pairs(seperatedSubtitles) do
        
    end
end


function writeSrts(redySubtitles)
    
end


aegisub.register_macro(script_name, script_description, main--[[, validateInput, is_active_function]])