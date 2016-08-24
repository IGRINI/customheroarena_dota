--[[
------------------------------------------------------------
table structure:

[boss_name]
{
	spawner = "BOSS_SPAWN_1"
	respawn = 5 -- in minutes
	until_respawn = 5 -- in minutres
}
------------------------------------------------------------
]]
local boss_table = {}

function InitBossTable(bosses_table)
	local names = 
	{
	}
	local respawn_time = 300 
	local until_respawn_time = 0

	for i, x in pairs(names) do
		AddBossToTable(bosses_table, i, x, respawn_time, until_respawn_time)
	end
end

function SetCustomBossUntilRespawnTime(boss_table, boss_name, respawn_time)
	boss_table[boss_name].until_respawn = respawn_time
end

function SetCustomBossRespawnTime(boss_table, boss_name, respawn_time)
	boss_table[boss_name].respawn = respawn_time
end

function AddBossToTable(bosses_table, boss_name, spawner_name, respawn_time, until_respawn_time)
	bosses_table[boss_name] = {
		spawner = spawner_name,
		respawn = respawn_time,
		until_respawn = until_respawn_time,
	}
end

InitBossTable(boss_table)

return boss_table

---------------------------------------------------------------------------
