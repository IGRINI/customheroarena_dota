local ability_list = {
	"earth_spirit_petrify",
	"ogre_magi_unrefined_fireblast",
	"shredder_chakram_2",
	"morphling_hybrid",
	"tusk_walrus_kick",
	"life_stealer_assimilate",
	"treant_eyes_in_the_forest",
}

function OnDealDamage(event)
	local caster = event.caster
	local damage = event.damage
	local target = event.unit
	local ability = event.ability
	local heal_pct_hero = event.heal_pct_hero / 100
	local heal_pct_creep = event.heal_pct_creep / 100
	if not target or not caster or not damage then return end
	local hero_health = caster:GetHealth() 
	if hero_health <= damage then return	end

	if target:IsIllusion() or caster:IsIllusion() then return end

	if target:IsRealHero() then
		caster:Heal(damage*heal_pct_hero, ability)
	end

	if not target:IsHero() then
		caster:Heal(damage*heal_pct_creep, ability)
	end
end

function OnCreated(event)
	local caster = event.caster
	local ability = event.ability

	caster:AddNewModifier(caster, ability, "modifier_octarine_ultimate_cooldown_lua",  { duration = -1} )
	caster:AddNewModifier(caster, ability, "modifier_item_ultimate_scepter_consumed", {})
	
	for _, ability_name in pairs(ability_list) do 
		if caster:HasAbility(ability_name) then
			caster:FindAbilityByName(ability_name):SetHidden(false)
			caster:FindAbilityByName(ability_name):SetLevel(1)
		end
	end
	
end

function OnDestroy(event)
	local caster = event.caster

	caster:RemoveModifierByName("modifier_octarine_ultimate_cooldown_lua")
	caster:RemoveModifierByName("modifier_item_ultimate_scepter_consumed")
end

function OnThink(event)
	local caster  = event.caster
	local ability = event.ability

	if not caster:HasModifier("modifier_octarine_ultimate_cooldown_lua") then
		caster:AddNewModifier(caster, ability, "modifier_octarine_ultimate_cooldown_lua",  {duration = -1} )
	end
end
