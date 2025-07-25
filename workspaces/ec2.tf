resource "aws_instance" "roboshop" {
  #----------------------count----------------------------
  count = length(var.instances) # create 4 instances [1_instances]
  #-------------------------ami------------------------------------
  ami = var.ami_id

  #-------------------------instance_type-----------------------------------
  #--[1_instance_type]----------
  #instance_type = var.instance_type # left side and right side name no need to be same
  #--[2_instance_type] ----------beacuse to check dv or prod required type 
  instance_type = lookup(var.instance_type,terraform.workspace)


  #----------------------------[vpc_security_group_ids]---------------------------------------------
  #For the next configuration, I don’t want to use the default VPC. I want to use the custom VPC I created earlier
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  #------------------------tags-----------------------------
  #---[1_tags]
  /* tags={
        Name = "hi-world" # [this type was string in variable.tf tags is created in the form of map(string)
      
    }*/
  #-----[2_tags]
  #tags=var.ec2_tags #this is for map(string) tags key where name and purpose
  #-- [3_tags]
  #this change was made to ensure that each instance in the loop receives a distinct name and learn count.index
  # list of instances created 


  tags = merge(
    var.common_tags,
    {
    Name = "${var.project}-${var.instances[count.index]}-${terraform.workspace}"
    component = var.instances[count.index]
    environment= terraform.workspace
  })
}




resource "aws_security_group" "allow_all" {
  name        = "${var.sg_name}-${terraform.workspace}"
  description = var.discription



  /*
   tags = {                
     Name = "allow_all"
   }
   */
  tags = merge(
    var.common_tags,{
      Name = "${var.project}-${var.sg_name}-${terraform.workspace}"
    }
  )
  #this is for map(string) tags key where name and purpose [2_tags]

  ingress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = var.from_port
    to_port          = var.to_port
    protocol         = "-1"
    cidr_blocks      = var.cidr_blocks
    ipv6_cidr_blocks = ["::/0"]
  }


}
