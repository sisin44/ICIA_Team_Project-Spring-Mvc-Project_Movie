package icia.kotlin.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

import icia.kotlin.beans.Movie;
import icia.kotlin.beans.Seat;
import icia.kotlin.mapper.ReservationIf;

@Service
public class Reservation {
	@Autowired
	private ReservationIf mapper;
	@Autowired
	private PlatformTransactionManager tran;
	@Autowired
	private Gson gson;
	public ModelAndView entrance(Movie mv) {

		ModelAndView mav = null;

		if (mv.getMvCode() == null) {
			mav = this.movieListCtl(mv);
		} else {
			switch (mv.getSCode()) {
			case "toDate":
				mav = this.DateCtl(mv);
				break;
			case "toTime":
				mav = this.TimeCtl(mv);
				break;
			case "toSeat":
				mav = this.SeatCtl(mv);
				break;
			default:
				break;
			}
		}
		return mav;

	}
	//좌석선택
	private ModelAndView SeatCtl(Movie mv) {
		ModelAndView mav = new ModelAndView();
		mv.setMvDate(mv.getMvDate().replace("/", ""));
		mv.setMvDateTime(mv.getMvDate() + mv.getMvDateTime());

		mav.addObject("getSeat", gson.toJson(this.getSeat(mv)));
		mav.setViewName("SeatChoice");
		return mav;
	}
	
	private ArrayList<Seat> getSeat(Movie mv) {
		return mapper.getSeat(mv);
		
	}
	
	//시간선택
	private ModelAndView TimeCtl(Movie mv) {
		
		
		ModelAndView mav = new ModelAndView();
		String jsonData = gson.toJson(this.getScreenInfo(mv));
		mav.addObject("Timeselection", jsonData);
		mav.setViewName("dateChoose");

		return mav;
	}

	private ArrayList<Movie> getScreenInfo(Movie mv) {
		return mapper.getScreenInfo(mv);
	}
	//날짜선택
	private ModelAndView DateCtl(Movie mv) {
		ModelAndView mav = new ModelAndView();
		//날짜
		mav.addObject("Access", this.getCurrentDate('d'));
		
		//서블릿에서 싱글톤:빈으로 설정후 오토와이드로 설정
		String jsonData = gson.toJson(this.getMovieList(mv));
		mav.addObject("SelectedMovie", jsonData);
		//mav.addObject("SelectedMovie", this.getMovieInfo(mv));
		mav.setViewName("dateChoose");
		return mav;
	}

	private Movie getMovieInfo(Movie mv) {
		return mapper.getMovieInfo(mv);
		
	}

	private ModelAndView movieListCtl(Movie mv) {
		ModelAndView mav = new ModelAndView();
		//날짜
		mav.addObject("Access", this.getCurrentDate('f'));
		

		String jsonData = gson.toJson(this.getMovieList(mv));
		mav.addObject("jsonData", jsonData);
		//mav.addObject("makeMovie", this.makeMovieList(this.getMovieList()));
		mav.setViewName("home");
		return mav;
	}

	private ArrayList<Movie> getMovieList(Movie mv) {

		return mapper.getMovieList(mv);

	}

	private String makeMovieList(ArrayList<Movie> mList) {
		StringBuffer sb = new StringBuffer();
		int index = 0;
		for (Movie movie : mList) {

			index++;

			// 3으로 나눠서 1이 나오면 이미를 하나씩 3개까지 출력
			if (index % 3 == 1) {
				sb.append("<div style=\"display: flex\">");
			}
			sb.append("<div onClick=\"toDate(\'" + movie.getMvCode() + "\')\">");
			sb.append("<div><img src=\"resources/image/" + movie.getMvImage() + "\" /></div>");
			sb.append("<div>" + movie.getMvName() + " / " + movie.getMvGrade() + "등급</div>");
			sb.append("</div>");

			// 3번째 상품씩 넘기기
			if (index % 3 == 0) {
				sb.append("</div>");
			}
		}

		if (index % 3 != 0) {
			sb.append("</div>");
		}
		
		return sb.toString();
	}
	
	private String getCurrentDate(char dateType) {
		Date date = new Date();
		
		SimpleDateFormat sdf = (dateType=='f')? new SimpleDateFormat("yyyy-MM-dd HH:mm:ss E요일") :
			(dateType=='d')? new SimpleDateFormat("yyyy-MM-dd") :
				(dateType=='t')? new SimpleDateFormat("HH:mm E요일") : null;
		return sdf.format(date);
	}
}
