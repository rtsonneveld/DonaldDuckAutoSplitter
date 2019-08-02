state("Donald")
{
    string9 levelID      : "Donald.exe", 0x1AE2A1;
    int finalBossStage : "Donald.exe", 0x1B0BA8, 0xE4, 0x4, 0x3C, 0x2C, 0x468;
	int finalBossFlag : "Donald.exe", 0x1B0BA8, 0xE4, 0x4, 0x3C, 0x2C, 0x470;
    byte engineState       : "Donald.exe", 0x1AE2A0; // 5 = loading, 9 = playing
}

start
{
    if (current.levelID.ToLower() == "mapmonde" && old.levelID.ToLower() == "menu" && old.engineState != 5)
        return true;
}

reset
{
    return current.levelID.ToLower() == "menu" &&
        old.levelID.ToLower() != "menu";
}

isLoading
{
    return current.engineState == 5;
}

split
{
    if (current.levelID.ToLower() == "mapmonde" && old.levelID.ToLower() != "mapmonde" && old.levelID.ToLower() != "menu")
        return true; // map screen entered
		
	// Final level
	if (current.levelID.ToLower() == "inca_boss") {
		// Last boss phase
		if (current.finalBossStage == 4) {
			// Final trigger
			if (current.finalBossFlag == 1 && old.finalBossFlag == 0) {
				return true;
			}
		}
	}

    
    return false;
}
