import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const WarrantyTrackerModule = buildModule("WarrantyTrackerModule", (m) => {

    const warranty = m.contract("WarrantyTracker");

    return { warranty };
});

export default WarrantyTrackerModule;
// contract address = 0x6e770D653B7b4b5e4BF9d6e403324Ead5B7125A1