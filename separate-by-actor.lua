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
    aegisub.log("Number of rows in ass file: %d",num_lines);

end

function validateInput()
    -- body
end

aegisub.register_macro(script_name, script_description, main--[[, validateInput, is_active_function]]);