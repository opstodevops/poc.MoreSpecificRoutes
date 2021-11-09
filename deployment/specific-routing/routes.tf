resource "aws_route" "bastion_route" {
    destination_cidr_block = "10.196.128.0/17"
    # instance_id = aws_instance.appliancehost.id
    network_interface_id = aws_instance.appliancehost.primary_network_interface_id
    route_table_id = "rtb-04249ebbdaf8c8716"
}

resource "aws_route" "appliance_route" {
    destination_cidr_block = "0.0.0.0/0"
    route_table_id = "rtb-0f33193685e4647f5"
    transit_gateway_id = "tgw-XXXXXXXXXXXX" # replace with IGW for demo 
}

resource "aws_route" "application_route" {
    destination_cidr_block = "10.196.0.0/17"
    # instance_id = aws_instance.appliancehost.id
    network_interface_id = aws_instance.appliancehost.primary_network_interface_id
    route_table_id = "rtb-04a49b6b896a8570c"
}

