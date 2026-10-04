# ProcessServer archive implementation plan

Make the legacy process-server artifacts understandable enough to decide whether any component should be revived.

Status: proposed next work, prepared from local source inspection on 2026-10-04. Existing behavior below has not been rerun or release-verified in this planning pass. Update this file as work lands; check an item only after recording its acceptance evidence.

## Current evidence

The repository contains AQPMon, ActOnAnyQ, BASH, BPELData, Contact_Gadget, Help_Pages, and redirectResource, including legacy branch and packaged artifacts. No root implementation guide was found.

## Pending implementation

- [ ] Create a component inventory identifying source versus packaged output, expected application server, and the purpose of each top-level component.
- [ ] Choose one component to preserve as a reference or revive; record missing dependencies and the smallest observable behavior.
- [ ] If revival is chosen, reconstruct that component in an isolated test environment using synthetic queues/data and document one successful request or job.

## Acceptance

The inventory identifies a usable source entry point and its runtime requirements. Any revived component demonstrates one bounded behavior without connecting to historical systems.

## Scope and decisions

No current product objective is evident. Preserve archive and branch contents; do not interpret packaged binaries or historical scripts as approved commands to execute.

## Sources

- [AQPMon](<AQPMon>)
- [ActOnAnyQ](<ActOnAnyQ>)
- [BASH](<BASH>)
- [BPELData](<BPELData>)
- [Help_Pages](<Help_Pages>)
