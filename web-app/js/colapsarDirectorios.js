$(document).ready(function() {
	folderCollapser();
});

function folderCollapser() {
	
	var myContentCollection = document.getElementsByTagName("div");
	
	for (var i = 0; i < myContentCollection.length; i++) {
		if (myContentCollection[i].className == "folder_content") {
			myContentCollection[i].style.display = "none";
		}
	}
	
	var myUnitClass = "folder_link";
	var myUnitLinkCollapsed = "folder_link_collapsed";
	var myUnitLinkExpanded = "folder_link_expanded";
	var myUnitContent = "folder_content";
	var myAnimationSpeed = "slow";

	myLinkCollection = document.getElementsByTagName("a");
	
	for (var i = 0; i < myLinkCollection.length; i++)
	{
		if (myLinkCollection[i].className == myUnitClass)
			{
				myLinkCollection[i].className = myUnitClass + " " + myUnitLinkCollapsed;
				myLinkCollection[i].onclick = function()
					{
					var myCurrentId = this.id;
					var myCurrentNumber = myCurrentId.replace(myUnitClass + "_", "");
					
					if (this.className == myUnitClass + " " + myUnitLinkCollapsed)
						{
						$("#" + myUnitContent + "_" + myCurrentNumber).slideDown(myAnimationSpeed);
						this.className = myUnitClass + " " + myUnitLinkExpanded;
						}
						else
						{
						$("#" + myUnitContent + "_" + myCurrentNumber).slideUp(myAnimationSpeed);
						this.className = myUnitClass + " " + myUnitLinkCollapsed;
						}
					return false;

					}

			}

	}
}
//-->