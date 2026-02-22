if curl --silent https://watsonnutrition.de/products/male-one | grep 'price__badge-sold-out' > /dev/null; then
	# pass
	true
else
	notify "Vitamines are available!" "Go to https://watsonnutrition.de/products/male-one"
fi
