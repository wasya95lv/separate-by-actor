--[[
README:

Omae wa moe shindeiru
]]

--
script_name = "Separate by \"Actor\"";
script_author = "Regnant";
script_versin = "0.1beta";
script_description = "Generate separate srt files based on string \"Actor\"";
--

function main(subtitles)
    -- body
    num_lines = subtitles.n;
    --aegisub.debug.out("Number of rows in ass file: %d",num_lines);
    for i=1,num_lines,1 do
        --aegisub.log("%s \n",subtitles[i].class);
        if subtitles[i].class == "dialogue" and not (subtitles[i].actor==".") then 
            --aegisub.log("%d.\n%s\n\n", i, subtitles[i].text);
            --aegisub.log("Actor: ###%s### \n", subtitles[i].actor);
            aegisub.log( convertRowToSrt( subtitles[i], i ) );
        end
    end

end

--Cheks if subtitles includes "Actor" field
function validateInput()
    -- body

end

--Converts time from ms to hh:mm:ss,ms format
function convertTime(input)
    hh = math.floor(input / (60 * 60 * 1000));
    mm = math.floor((input / (1000 * 60))) % 60;
    ss = math.floor((input / 1000)) % 60;
    ms = input % 1000;

    return string.format("%02d:%02d:%02d,%03d", hh, mm, ss, ms);
end

--Converts line from ASS to SRT format
function convertRowToSrt(row, number) 
    startTime = convertTime(row.start_time);
    endTime = convertTime(row.end_time);
    dialogue = row.text:gsub("\\N","\n"):gsub("{.*}","");
    return string.format("\n%d\n%s --> %s\n%s\n", number, startTime,endTime,dialogue);
end

aegisub.register_macro(script_name, script_description, main--[[, validateInput, is_active_function]]);