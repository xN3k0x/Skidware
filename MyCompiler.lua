--[[
    INSPIRED BY BRAINFUCK
    cells:
        x: min 1 max 64
        y: min 1 max 64
    commands:
        ">": increase cell pointer in "x"
        ">>": increase cell pointer in "y"
        "<": decrease cell pointer in "x"
        "<<": decrease cell pointer in "y"
        "+": increase byte in pointing cell by 1
        "-": decrease byte in pointing cell by 1
        "#": output the byte in character
        "(": start the loop 
        ")": checking if pointing cell is not 0 will go to the start of the loop
    *in this compiler can't make nested loop cause i'm too lazyy 😎*
        
]]

local compiler = function(source)
    local in_loop = function(st, index, cell_datas, cell_pointer)
        local output = ""
        if st[index] == ">" then
            if st[index+1] == ">" then
                index = index + 1
                cell_pointer["y"] = cell_pointer["y"] + 1
                
                if cell_pointer["y"] > 64 then
                    cell_pointer["y"] = 1
                end
            else
                cell_pointer["x"] = cell_pointer["x"] + 1
                if cell_pointer["x"] > 64 then
                    cell_pointer["x"] = 1
                end
            end
        elseif st[index] == "<" then
            if st[index+1] == "<" then
                index = index + 1
                cell_pointer["y"] = cell_pointer["y"] - 1
                if cell_pointer["y"] < 1 then
                    cell_pointer["y"] = 64
                end
            else
                cell_pointer["x"] = cell_pointer["x"] - 1
                if cell_pointer["x"] < 1 then
                    cell_pointer["x"] = 64
                end
            end
        elseif st[index] == "+" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] then
                cell_datas[cell] = cell_datas[cell] + 1
                if cell_datas[cell] > 255 then
                    cell_datas[cell] = 1
                end
            else
                cell_datas[cell] = 1
            end
        elseif st[index] == "-" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] then
                cell_datas[cell] = cell_datas[cell] - 1
                if cell_datas[cell] < 0 then
                    cell_datas[cell] = 255
                end
            else
                cell_datas[cell] = 255
            end
        elseif st[index] == "#" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] == nil then cell_datas[cell] = 0 end
            output = output..string.char(cell_datas[cell])
        end
        return {cell_datas,cell_pointer,output}
    end

    local output = ""

    local cell_pointer = {
        ["x"] = 1,
        ["y"] = 1
    }
    local cell_datas = {}

    local index = 1
    local st = (function()
        local t = {}
        source:gsub(".", function(c)
            table.insert(t, c)
        end)
        return t
    end)()

    for i = 1,#st+1 do
        if st[index] == ">" then
            if st[index+1] == ">" then
                index = index + 1
                cell_pointer["y"] = cell_pointer["y"] + 1
                
                if cell_pointer["y"] > 64 then
                    cell_pointer["y"] = 1
                end
            else
                cell_pointer["x"] = cell_pointer["x"] + 1
                if cell_pointer["x"] > 64 then
                    cell_pointer["x"] = 1
                end
            end
        elseif st[index] == "<" then
            if st[index+1] == "<" then
                index = index + 1
                cell_pointer["y"] = cell_pointer["y"] - 1
                if cell_pointer["y"] < 1 then
                    cell_pointer["y"] = 64
                end
            else
                cell_pointer["x"] = cell_pointer["x"] - 1
                if cell_pointer["x"] < 1 then
                    cell_pointer["x"] = 64
                end
            end
        elseif st[index] == "+" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] then
                cell_datas[cell] = cell_datas[cell] + 1
                if cell_datas[cell] > 255 then
                    cell_datas[cell] = 1
                end
            else
                cell_datas[cell] = 1
            end
        elseif st[index] == "-" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] then
                cell_datas[cell] = cell_datas[cell] - 1
                if cell_datas[cell] < 0 then
                    cell_datas[cell] = 255
                end
            else
                cell_datas[cell] = 255
            end
        elseif st[index] == "#" then
            local cell = table.concat({cell_pointer["x"],"|",cell_pointer["y"]})
            if cell_datas[cell] == nil then cell_datas[cell] = 0 end
            output = output..string.char(cell_datas[cell])
        elseif st[index] == "(" then
            local commands = {}
            local command_index = 1

            while true do
                index = index + 1
                if st[index] == ")" then
                    break
                else
                    table.insert(commands, st[index])
                end
            end
            
            while true do
                local data = in_loop(commands, command_index, cell_datas, cell_pointer)
                cell_datas,cell_pointer,output = data[1],data[2],output..data[3]
                command_index = command_index + 1
                if commands[command_index] == nil then
                    local cell = cell_datas[table.concat({cell_pointer["x"],"|",cell_pointer["y"]})]
                    if cell == 0 or cell == nil then
                        break
                    else
                        command_index = 1
                    end
                end
            end
        elseif st[index] == nil then
            return table.concat({"Pointer: X:",cell_pointer["x"],"   Y:",cell_pointer["y"],"\nOutput: ",output})
        end
        index = index + 1
    end
end

print(compiler([==[
++++++++++(>+++++++<-)>++#>>++++++++++(>++++++++++>++++++++++ < <-)>+#>++++++++##>>+++++++++++(>++++++++++<-)>+#>>+++++(>++++++<-)>++#
>>++++++++(>++++++++++<-)>+++++++#>>++++++++++(>++++++++++>++++++++++>++++++++++>++++++++++< < < <-)>+++++++++++#>++++++++++++++#>++++++++#>#> >>+++++(>++++++<-)>+++#
]==]))
