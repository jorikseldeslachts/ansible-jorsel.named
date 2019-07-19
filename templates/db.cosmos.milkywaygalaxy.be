$TTL 86400 
@	IN	SOA	 ns.cosmos.milkywaygalaxy.be. jorik.cosmos.milkywaygalaxy.be. (
					2018072003	; serial
					1D		; refresh
					1H		; retry
					1W		; expire
					3H 		; minimum
)

; name servers - NS recors
       		IN	NS	ns.cosmos.milkywaygalaxy.be.

; name servers - A & CNAME records
ns		IN	A	10.0.0.11
dns2		IN	CNAME	ns

; 10.0.0.0/24 - A records
deathstar	IN	A	10.0.0.1
starlight	IN	A	10.0.0.2
delta		IN	A	10.0.0.3
ap1-boven	IN	A	10.0.0.4
ap2-beneden	IN	A	10.0.0.5
printer		IN	A	10.0.0.6	
raspberrypi	IN	A	10.0.0.7
homecontrol	IN	A	10.0.0.7
pandora		IN	A	10.0.0.8
pandora-NIC2	IN	A	10.0.0.9
pandora-ipmi	IN	A	10.0.0.10
omega		IN	A	10.0.0.12
atlantis	IN	A	10.0.0.13
webby1		IN	A	10.0.0.14
webby2		IN	A	10.0.0.15
minecraft1	IN	A	10.0.0.16
minecraft2	IN	A	10.0.0.17
nextcloudserver	IN	A	10.0.0.18
blackhole	IN	A	10.0.0.19
darkmatter	IN	A	10.0.0.20
veeamserver	IN	A	10.0.0.21
