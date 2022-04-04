local PetsEquipped = {}

function CollectOrbs()
    for _, v in next, game:GetService("Workspace")["__THINGS"].Orbs:GetChildren() do
        local args = {[1] = {[1] = {[1] = v.Name}}}

        workspace.__THINGS.__REMOTES:FindFirstChild("claim orbs"):FireServer(unpack(args)) 
    end
end

function GetPetsEquipped()
    table.clear(PetsEquipped)
    for _,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Inventory.Frame.Main.Pets:GetChildren()) do
        if v.ClassName == "TextButton" and v.BackgroundColor3 == Color3.fromRGB(69, 239, 69) then
            insert = true
            for _,v2 in pairs(PetsEquipped) do if v2 == v.Name then insert = false end end
            if insert then table.insert(PetsEquipped, v.Name) end
        end
    end
end

function CollectBags()
    for i,v in pairs(game:GetService("Workspace")["__THINGS"].Lootbags:GetChildren()) do
        v.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
    end
end

function FarmCoins()
    local Event = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in next, Event do
        if v.w == getgenv().World and string.find(v.a, getgenv().Area) then
                local pets = PetsEquipped[math.random(1, #PetsEquipped)]
                local args = {
                    [1] = {
                        [1] = i, --Coin Id
                        [2] = {
                            [1] = pets --Pet Id?
                        }
                    }
                }
                    
                workspace.__THINGS.__REMOTES:FindFirstChild("join coin"):InvokeServer(unpack(args))
                local args2 = {
                    [1] = {
                        [1] = pets,
                        [2] = "Coin",
                        [3] = i
                    }
                }

                workspace.__THINGS.__REMOTES:FindFirstChild("change pet target"):FireServer(unpack(args2))
                local args3 = {
                    [1] = {
                        [1] = i,
                        [2] = pets
                    }
                }

                workspace.__THINGS.__REMOTES:FindFirstChild("farm coin"):FireServer(unpack(args3))
                CollectOrbs()
                CollectBags()
        end
    end
end

function TargetFarmCoins()
    GetPetsEquipped()
    CollectOrbs()
    local Event = game.workspace['__THINGS']['__REMOTES']["get coins"]:InvokeServer({})[1]
    for i,v in next, Event do
        if v.w == getgenv().World and string.find(v.a, getgenv().Area) and string.find(v.n, getgenv().TargetType) then
                local pets = PetsEquipped[math.random(1, #PetsEquipped)]
                local args = {
                    [1] = {
                        [1] = i, --Coin Id
                        [2] = {
                            [1] = pets --Pet Id?
                        }
                    }
                }
                    
                workspace.__THINGS.__REMOTES:FindFirstChild("join coin"):InvokeServer(unpack(args))
                local args2 = {
                    [1] = {
                        [1] = pets,
                        [2] = "Coin",
                        [3] = i
                    }
                }

                workspace.__THINGS.__REMOTES:FindFirstChild("change pet target"):FireServer(unpack(args2))
                local args3 = {
                    [1] = {
                        [1] = i,
                        [2] = pets
                    }
                }

                workspace.__THINGS.__REMOTES:FindFirstChild("farm coin"):FireServer(unpack(args3))
                CollectOrbs()
                CollectBags()
        end
    end
end

while getgenv().Enabled == true do wait()
    if getgenv().TargetMode == false then
            GetPetsEquipped()
            FarmCoins()
        else
            GetPetsEquipped()
            TargetFarmCoins()
    end
end
