gpart -i $num -l $label $vdev

zpool detach zroot $vdev

zpool attach zroot $left_over_vdev gpt/$label

# repeat for the rest
