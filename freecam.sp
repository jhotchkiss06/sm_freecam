#include <sourcemod>
#include <sdktools>
#include <cstrike>

#define SPECMODE_NONE           0
#define SPECMODE_FIRSTPERSON    4
#define SPECMODE_3RDPERSON      5
#define SPECMODE_FREELOOK       6 

public Plugin myinfo = 
{
	name = "Freecam",
	author = "danielyeetman",
	description = "Allows users to spectate their current position",
	version = "1",
	url = "https://steamcommunity.com/id/danielyeetman/"
};

public void OnPluginStart()
{
    RegConsoleCmd("sm_freecam", Command_spec, "Spectate your current position");
}

public Action Command_spec(int client, int args)
{
    if (!IsPlayerAlive(client))
    {
        return Plugin_Handled;
    }
    
    float vectors[3];
    GetClientEyePosition(client, vectors);
    ChangeClientTeam(client, CS_TEAM_SPECTATOR);
    SetEntProp(client, Prop_Send, "m_iObserverMode", SPECMODE_FREELOOK);
    TeleportEntity(client, vectors, NULL_VECTOR, NULL_VECTOR);
    
    return Plugin_Handled;


}