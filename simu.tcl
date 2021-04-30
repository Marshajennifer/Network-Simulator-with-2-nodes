set ns [new Simulator]

set tracefile [open simu.tr w]
$ns trace-all $tracefile


set namfile [open simu.nam w]
$ns namtrace-all $namfile


set n0 [$ns node]
set n1 [$ns node]


$ns duplex-link $n0 $n1 5Mb 3ms DropTail



set udp [new Agent/UDP]
set null [new Agent/Null]


$ns attach-agent $n0 $udp
$ns attach-agent $n1 $null

$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

$ns at 1.0 "$cbr start"

$ns at 10.0 "finish"

proc finish {} {
	global ns tracefile namfile
	$ns flush-trace
	close $tracefile
	close $namfile
	exit 0
}
puts "Simulation is Starting"
$ns run
