/**
 * VU Progression - Ribbon Notification System
 * Handles queueing and displaying ribbon animations on the client HUD.
 */

(function() {
    // Map Lua Ribbon Config keys to their respective PNG files in WebUI/images/
    const ribbonImageMap = {
        // Combat / Action Ribbons
        'AssaultRifle': 'Assault_Rifle_Ribbon.png',
        'LMG': 'Light_Machine_Gun_Ribbon.png',
        'Carbine': 'Carbine_Ribbon.png',
        'Handgun': 'Handgun_Ribbon.png',
        'SniperRifle': 'Sniper_Rifle_Ribbon.png',
        'PDW': 'PDW_Ribbon.png',
        'Shotgun': 'Shotgun_Ribbon.png',
        'DisableVehicle': 'Disable_Vehicle_Ribbon.png',
        'Melee': 'Melee_Ribbon.png',
        'Resupply': 'Resupply_Efficiency_Ribbon.png',
        'Surveillance': 'Surveillance_Efficiency_Ribbon.png',
        'Medical': 'Medical_Efficiency_Ribbon.png',
        'FlagDefender': 'Flag_Defender_Ribbon.png',
        'FlagAttacker': 'Flag_Attacker_Ribbon.png',
        'McomDefender': 'M-COM_Defender_Ribbon.png',
        'McomAttacker': 'M-COM_Attacker_Ribbon.png',
        'AirWarfare': 'Air_Warfare_Ribbon.png',
        'Stationary': 'Stationary_Emplacement_Ribbon.png',
        'ArmoredWarfare': 'Armored_Warfare_Ribbon.png',
        'TransportWarfare': 'Transport_Warfare_Ribbon.png',
        'SquadWipe': 'Squad_Wipe_Ribbon.png',
        'SquadSpawn': 'Squad_Spawn_Ribbon.png',
        'AntiExplosives': 'Anti_Explosives_Ribbon.png',
        'CombatEfficiency': 'Combat_Efficiency_Ribbon.png',
        'MVP': 'MVP_Ribbon.png',
        'MVP2': 'MVP_2_Ribbon.png',
        'MVP3': 'MVP_3_Ribbon.png',
        'Nemesis': 'Nemesis_Ribbon.png',
        'Suppression': 'Suppression_Ribbon.png',
        'Avenger': 'Avenger_Ribbon.png',
        'Savior': 'Savior_Ribbon.png',
        'AntiVehicle': 'Anti_Vehicle_Ribbon.png',
        'Accuracy': 'Accuracy_Ribbon.png',
        'Maintenance': 'Maintainence_Efficiency_Ribbon.png', // Special mapping spelling case
        'AceSquad': 'Ace_Squad_Ribbon.png',
        
        // Round Completion Ribbons
        'SquadRush': 'Squad_Rush_Ribbon.png',
        'SquadDeathmatch': 'Squad_Deathmatch_Ribbon.png',
        'Rush': 'Rush_Ribbon.png',
        'Conquest': 'Conquest_Ribbon.png',
        'TeamDeathmatch': 'Team_Deathmatch_Ribbon.png',
        'TDMCQ': 'Tdmcq-round-ribbon.png',
        'TankSuperiority': 'Tanksuperiorityribbon.png',
        'Scavenger': 'Scavenger_ribbon.png',
        'Domination': 'Conquest_dominationribbon.png',
        'GunMaster': 'Gmribbon.png',
        'CaptureTheFlag': 'BF3_Capture_the_Flag_Ribbon.png',
        'AirSuperiority': 'BF3_Air_Superiority_Ribbon.png',

        // Round Winner Ribbons
        'RushWinner': 'Rush_Winner_Ribbon.png',
        'ConquestWinner': 'Conquest_Winner_Ribbon.png',
        'TDMWinner': 'TDM_Winner.png',
        'SquadRushWinner': 'Squad_Rush_Winner.png',
        'SquadDeathmatchWinner': 'Squad_Deathmatch_Winner.png',
        'TDMCQWinner': 'Tdmcq-winner-ribbon.png',
        'TankSuperiorityWinner': 'Tanksuperiority2d.png',
        'ScavengerWinner': 'Scavengerribbon.png',
        'DominationWinner': 'Conquest_domination2d.png',
        'GunMasterWinner': 'Gunmaster2d.png',
        'CaptureTheFlagWinner': 'BF3_Capture_the_Flag_Winner_Ribbon.png',
        'AirSuperiorityWinner': 'BF3_Air_Superiority_Winner_Ribbon.png',
    };

    const ribbonQueue = [];
    let isDisplaying = false;

    /**
     * Queues a ribbon award and starts processing the queue.
     * Exposed to the global window object for VEXT Client Lua calls.
     * @param {Object} data - Ribbon award payload.
     * @param {string} data.key - Unique identifier of the ribbon configuration.
     * @param {string} data.name - Display name of the ribbon.
     * @param {string} data.desc - Unlock/award description.
     * @param {number} data.xp - Experience points awarded.
     * @param {number} [data.duration] - Display duration in milliseconds.
     * @returns {void}
     */
    window.showRibbon = function(data) {
        if (!data || !data.key) {
            console.warn("[WebUI] Received invalid ribbon data:", data);
            return;
        }
        ribbonQueue.push(data);
        processQueue();
    };

    /**
     * Checks if a ribbon can be displayed and pops the next ribbon from the queue.
     * @returns {void}
     */
    function processQueue() {
        if (isDisplaying || ribbonQueue.length === 0) {
            return;
        }

        isDisplaying = true;
        const currentRibbon = ribbonQueue.shift();
        displayRibbon(currentRibbon);
    }

    /**
     * Dynamically creates a ribbon card, triggers animations, plays sequential client sound,
     * and schedules the card's destruction after the configured display duration.
     * @param {Object} data - Ribbon configuration and display details.
     * @returns {void}
     */
    function displayRibbon(data) {
        const container = document.getElementById('ribbon-container');
        if (!container) {
            console.error("[WebUI] Ribbon container element not found!");
            isDisplaying = false;
            return;
        }

        // Map key to the correct image file
        const imageName = ribbonImageMap[data.key] || 'MVP_Ribbon.png';
        const imagePath = `images/${imageName}`;

        // Create the card element
        const card = document.createElement('div');
        card.className = 'ribbon-card';

        card.innerHTML = `
            <div class="ribbon-title">${data.name}</div>
            <div class="ribbon-image-container">
                <img class="ribbon-image main" src="${imagePath}" alt="${data.name}">
                <img class="ribbon-image glitch-cyan" src="${imagePath}" alt="${data.name}">
                <img class="ribbon-image glitch-red" src="${imagePath}" alt="${data.name}">
                <div class="ribbon-scanlines" style="-webkit-mask-image: url('${imagePath}'); mask-image: url('${imagePath}');"></div>
            </div>
            <div class="ribbon-xp">+${data.xp}</div>
        `;

        container.appendChild(card);

        // Use a short setTimeout to yield execution, guaranteeing that the browser
        // registers the initial states (opacity 0, scale 0.15) before transitioning.
        setTimeout(() => {
            card.classList.add('show');
            // Play sound via client Lua
            if (typeof WebUI !== 'undefined') {
                WebUI.Call('DispatchEventLocal', 'PlayRibbonSound');
            }
        }, 50);

        // Trigger glitch effects (RGB split, blocks, laser scan) only in the middle (from 0.5s to 2.2s)
        let glitchStartTimeout = setTimeout(() => {
            card.classList.add('glitch-active');
        }, 500);

        let glitchEndTimeout = setTimeout(() => {
            card.classList.remove('glitch-active');
        }, 2200);

        // Keep displayed for the configured duration (default to 2.5s)
        const displayDuration = (data.duration && data.duration > 100) ? data.duration : 2500;
        const transitionDuration = 400; // time in ms for transition in CSS (0.4s)

        setTimeout(() => {
            clearTimeout(glitchStartTimeout);
            clearTimeout(glitchEndTimeout);
            card.classList.remove('show');
            card.classList.add('hide');

            // Set up listener to remove element after fade-out transition completes
            let transitionEnded = false;
            
            const handleTransitionEnd = (event) => {
                // Ensure we handle transitions on opacity or transform
                if (event.propertyName === 'opacity' || event.propertyName === 'transform') {
                    if (transitionEnded) return;
                    transitionEnded = true;
                    
                    card.removeEventListener('transitionend', handleTransitionEnd);
                    card.remove();
                    
                    isDisplaying = false;
                    // Introduce a tiny delay between consecutive ribbons
                    setTimeout(processQueue, 150);
                }
            };

            card.addEventListener('transitionend', handleTransitionEnd);

            // Safety fallback in case transitionend event doesn't fire (e.g. blurred window)
            setTimeout(() => {
                if (!transitionEnded) {
                    transitionEnded = true;
                    if (card.parentNode) {
                        card.remove();
                    }
                    isDisplaying = false;
                    setTimeout(processQueue, 150);
                }
            }, transitionDuration + 200);

        }, displayDuration);
    }
})();
