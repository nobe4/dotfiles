from datetime import datetime
from subprocess import run

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer, get_options
from kitty.utils import color_as_int
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
)

opts = get_options()
clock_color = as_rgb(color_as_int(opts.color15))

REFRESH_TIME_SECONDS = 1
timer_id = None


def _draw_right_status(
    screen: Screen,
) -> int:
    right_status_length = 0

    battery_percent = (
        run("/Users/nobe4/.config/dotfiles/bin/battery_percent", capture_output=True)
        .stdout.strip()
        .decode("utf8")
        + " "
    )
    right_status_length += len(battery_percent)

    clock = datetime.now().strftime("%m/%d %H:%M ")
    right_status_length += len(clock)

    draw_attributed_string(Formatter.reset, screen)
    screen.cursor.x = screen.columns - right_status_length

    screen.cursor.fg = clock_color
    screen.draw(battery_percent)
    screen.draw(clock)

    return screen.cursor.x


def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    index: int,
) -> int:
    # the first tab has index 1
    if index == 1:
        screen.draw(f"[{get_boss().mappings.current_keyboard_mode_name}]")

    draw_title(draw_data, screen, tab, index)


def _redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME_SECONDS, True)

    _draw_left_status(draw_data, screen, tab, index)

    # after the last tab, we draw the right side
    if is_last:
        _draw_right_status(screen)

    return screen.cursor.x
