package icia.kotlin.mapper;

import java.util.ArrayList;

import icia.kotlin.beans.Movie;
import icia.kotlin.beans.Seat;

public interface ReservationIf {
	public ArrayList<Movie> getMovieList(Movie mv);
	public Movie getMovieInfo(Movie mv);
	public ArrayList<Movie> getScreenInfo(Movie mv);
	public ArrayList<Seat> getSeat(Movie mv);
}
