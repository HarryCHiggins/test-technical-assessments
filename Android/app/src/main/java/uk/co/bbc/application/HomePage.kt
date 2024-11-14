package uk.co.bbc.application

import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowDropDown
import androidx.compose.material.icons.filled.Refresh
import androidx.compose.material3.BasicAlertDialog
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.res.vectorResource
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import uk.co.bbc.application.ui.theme.ApplicationTheme
import java.text.SimpleDateFormat
import java.util.Date

@Composable
fun HomePage(
    modifier: Modifier = Modifier,
    onBreakingNewsClick: () -> Unit,
    goToClicked: (String) -> Unit,
    title: String,
    onDropdownItemClick: (String, Int) -> Unit,
    itemPosition: Int,
    onRefreshClick: () -> Unit
) {

    val currentDateAndTime = rememberSaveable { mutableStateOf(Date()) }

    Box(modifier = Modifier.fillMaxSize()) {
        Column(
            modifier = Modifier.fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Top
        ) {
            Image(
                imageVector = ImageVector.vectorResource(R.drawable.bbc_logo),
                contentDescription = "BBC Logo",
                modifier = Modifier
                    .padding(top = 20.dp)
            )
            Spacer(Modifier.padding(bottom = 50.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = stringResource(R.string.page_title),
                    fontSize = 35.sp,
                    modifier = Modifier.padding(horizontal = 30.dp)
                )
                RefreshButton({
                    onRefreshClick()
                    currentDateAndTime.value = Date()
                })
            }
            Image(
                painter = painterResource(R.mipmap.bbc_broadcasting_house_foreground),
                contentDescription = "BBC Logo",
                modifier = Modifier
                    .fillMaxWidth()
                    .size(350.dp)
            )
            Subheading(currentDateAndTime.value)
            Spacer(Modifier.padding(bottom = 15.dp))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(text = "Go to $title ",
                    modifier = Modifier
                        .padding(horizontal = 16.dp)
                        .clickable { goToClicked(title) }
                )
                PickerDropdownMenu(onClick = onDropdownItemClick, itemPosition)
            }

            Spacer(Modifier.padding(bottom = 150.dp))
            Footer(
                onBreakingNewsClick, modifier = Modifier
                    .padding(80.dp)
            )
        }
    }
}

@Composable
fun Subheading(currentTime: Date) {
    val dayFormat = SimpleDateFormat("dd MMM yyyy")
    val timeFormat = SimpleDateFormat("hh:mm:ss")
    val day = dayFormat.format(currentTime)
    val time = timeFormat.format(currentTime)


    Text(
        text = "Last updated: $day at $time",
        modifier = Modifier.padding(bottom = 10.dp)
    )
    Text(
        text = stringResource(R.string.subtitle_text),
        modifier = Modifier.padding(horizontal = 45.dp)
    )
}

@Composable
fun PickerDropdownMenu(onClick: (String, Int) -> Unit, itemPosition: Int) {

    val dropdownExpanded = rememberSaveable { mutableStateOf(false) }
    val topics = listOf("Politics", "UK", "Sport", "Technology", "World", "TV Guide")


    Box(
        modifier = Modifier.padding(end = 16.dp)
    ) {
        Row(horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically,
            modifier = Modifier.clickable { dropdownExpanded.value = true }
        ) {
            Text(text = topics[itemPosition])
            Icon(imageVector = Icons.Default.ArrowDropDown, contentDescription = null)
        }
        DropdownMenu(
            expanded = dropdownExpanded.value,
            onDismissRequest = { dropdownExpanded.value = false }
        ) {
            topics.forEachIndexed { index, currentCategory ->
                DropdownMenuItem(
                    onClick = {
                        onClick(topics[index], index)
                        dropdownExpanded.value = false
                    },
                    text = { Text(text = currentCategory) }
                )
            }
        }
    }

}

@Composable
@OptIn(ExperimentalMaterial3Api::class)
fun LoadingDialog() {

    BasicAlertDialog(
        onDismissRequest = { },
    ) {
        Column(
            verticalArrangement = Arrangement.Center,
            horizontalAlignment = Alignment.CenterHorizontally,
            modifier = Modifier
                .padding(12.dp)
        ) {
            CircularProgressIndicator()
        }
    }
}

@Composable
fun Footer(onBreakingNewsClick: () -> Unit, modifier: Modifier) {

    Button(
        onClick = onBreakingNewsClick,
        colors = ButtonDefaults.buttonColors(containerColor = Color.Red)
    ) {
        Text(text = stringResource(R.string.breaking_news))
    }
}

@Composable
fun RefreshButton(onRefreshClick: () -> Unit) {
    Box {
        Icon(
            imageVector = Icons.Filled.Refresh,
            contentDescription = null,
            tint = Color.Blue,
            modifier = Modifier
                .padding(horizontal = 25.dp)
                .clickable {
                    onRefreshClick()
                }
        )
    }
}

@Preview(showBackground = true)
@Composable
fun HomePagePreview() {
    ApplicationTheme {
        HomePage(
            onBreakingNewsClick = { },
            goToClicked = {},
            title = "Politics",
            onDropdownItemClick = { _, _ -> },
            itemPosition = 1,
            onRefreshClick = { }
        )
    }
}