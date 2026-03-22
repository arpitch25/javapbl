package servlet;

import dao.CityDAO;
import dao.PlaceDetailDAO;
import model.City;
import model.PlaceDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

/**
 * PlaceDetailServlet — handles place detail page.
 * URL: /place?id=1
 *
 * Fetches: core place info, photos, activities, popular things.
 * Forwards to: place.jsp
 */
@WebServlet("/place")
public class PlaceDetailServlet extends HttpServlet {

    private PlaceDetailDAO placeDetailDAO;
    private CityDAO        cityDAO;

    @Override
    public void init() {
        placeDetailDAO = new PlaceDetailDAO();
        cityDAO        = new CityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int placeId;
        try {
            placeId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            PlaceDetail place = placeDetailDAO.getPlaceDetail(placeId);

            if (place == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Place not found");
                return;
            }

            // Fetch parent city for breadcrumb and sidebar
            City city = cityDAO.getCityById(place.getCityId());

            // Pass to JSP
            request.setAttribute("place", place);
            request.setAttribute("city",  city);

            // Track in session
            request.getSession().setAttribute("lastCityId",   city.getId());
            request.getSession().setAttribute("lastCityName", city.getName());

            request.getRequestDispatcher("/WEB-INF/place.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error loading place details", e);
        }
    }
}
