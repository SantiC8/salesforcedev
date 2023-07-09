sfdx force:org:create -f config\project-scratch-def.json --setalias trailhead --durationdays 7 --setdefaultusername --json --loglevel fatal
sfdx force:source:push
sfdx force:user:permset:assign -n DreamHouse