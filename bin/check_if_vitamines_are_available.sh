if curl --silent https://watsonnutrition.de/products/male-one | grep 'price__badge-sold-out' > /dev/null; then
	notify -t 1000 "Vitamines are not available!"
else
	notify "Vitamines are available!" "Go to https://watsonnutrition.de/products/male-one"
fi
